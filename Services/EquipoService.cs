using System.Linq;
using System.Xml.Linq;
using EquipoNatacionService.Data;
using EquipoNatacionService.Models;
using EquipoNatacionService.Utils;
using Microsoft.EntityFrameworkCore;

namespace EquipoNatacionService.Services
{
    [System.ServiceModel.ServiceContract]
    public interface IEquipoService
    {
        [System.ServiceModel.OperationContract]
        string RegistrarEquipoNatacion(string xmlDatos);

        [System.ServiceModel.OperationContract]
        string ConsultarEquipoNatacion(string nombreEquipo);
    }

    public class EquipoService : IEquipoService
    {
        private readonly OracleDbContext _context;

        public EquipoService(OracleDbContext context)
        {
            _context = context;
        }

        // --------------------------------------------------------------------
        // 🧾 Registrar un equipo completo desde XML (EQUIPO + MIEMBROS)
        // --------------------------------------------------------------------
        public string RegistrarEquipoNatacion(string xmlDatos)
        {
            try
            {
                var equipo = XmlParser.ParseEquipo(xmlDatos);

                // Verificar si ya existe
                var existente = _context.Equipos
                    .FirstOrDefault(e => e.NombreEquipo == equipo.NombreEquipo);

                if (existente != null)
                    return $"<Error>El equipo '{equipo.NombreEquipo}' ya existe en la base de datos.</Error>";

                _context.Equipos.Add(equipo);
                _context.SaveChanges();

                return $"<Resultado>OK|Equipo '{equipo.NombreEquipo}' registrado con {equipo.Miembros.Count} miembros.</Resultado>";
            }
            catch (Exception ex)
            {
                return $"<Error>Error al registrar el equipo: {ex.Message}</Error>";
            }
        }

        // --------------------------------------------------------------------
        // 🔍 Consultar un equipo por su nombre (JOIN con MIEMBROS)
        // --------------------------------------------------------------------
        public string ConsultarEquipoNatacion(string nombreEquipo)
        {
            try
            {
                var equipo = _context.Equipos
                    .Include(e => e.Miembros)
                    .FirstOrDefault(e => e.NombreEquipo == nombreEquipo);

                if (equipo == null)
                    return $"<Error>Equipo '{nombreEquipo}' no encontrado</Error>";

                return XmlParser.ToXml(equipo);
            }
            catch (Exception ex)
            {
                return $"<Error>Error al consultar el equipo: {ex.Message}</Error>";
            }
        }
    }
}
