using System.ComponentModel.DataAnnotations.Schema;

namespace EquipoNatacionService.Models
{
    public class EquipoNatacion
    {
        public long IdEquipo { get; set; }
        public string NombreEquipo { get; set; }
        public string Entrenador { get; set; }
        public string Ciudad { get; set; }
        public int CantidadMiembros { get; set; }
        public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;

        public List<MiembroEquipo> Miembros { get; set; } = new();
    }

    public class MiembroEquipo
    {
        public long IdMiembro { get; set; }
        public long IdEquipo { get; set; }
        public string Nombre { get; set; }
        public int Edad { get; set; }
        public string Estilo { get; set; }
        public string TiempoMejor { get; set; }

        [ForeignKey("IdEquipo")]
        public EquipoNatacion Equipo { get; set; }
    }
}
