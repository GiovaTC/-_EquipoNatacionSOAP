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
        public string RegistrarEquipoNatacion(string xmlDatos)
        {
             var equipo = XmlParser.ParseEquipo(xmlDatos);
             _context.Equipos.Add(equipo);
             _context.SaveChanges();
                return $"OK|Equipo '{equipo.NombreEquipo}' registrado con {equipo.Miembros.Count} miembros.";
        }
        public string ConsultarEquipoNatacion(string nombreEquipo)
        {
             var equipo = _context.Equipos
                 .Include(e => e.Miembros)
                 .FirstOrDefault(e => e.NombreEquipo == nombreEquipo);
             if (equipo == null)
                return "<Error>Equipo no encontrado</Error>";

             return XmlParser.ToXml(equipo);

        }
    }
}
