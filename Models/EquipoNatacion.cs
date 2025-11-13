using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace EquipoNatacionService.Models
{
    // ===========================
    // 🏊 Clase principal: EQUIPO
    // ===========================
    [Table("EQUIPO_NATACION", Schema = "SYSTEM")]
    public class EquipoNatacion
    {
        [Column("ID_EQUIPO")]
        public long IdEquipo { get; set; }

        [Column("NOMBRE_EQUIPO")]
        public string NombreEquipo { get; set; } = string.Empty;

        [Column("ENTRENADOR")]
        public string Entrenador { get; set; } = string.Empty;

        [Column("CIUDAD")]
        public string Ciudad { get; set; } = string.Empty;

        [Column("CANTIDAD_MIEMBROS")]
        public int CantidadMiembros { get; set; }

        [Column("FECHA_REGISTRO")]
        public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;

        // Relación 1:N con los miembros
        public List<MiembroEquipo> Miembros { get; set; } = new();
    }

    // ===========================
    // 🧍 Clase hija: MIEMBRO
    // ===========================
    [Table("MIEMBRO_EQUIPO", Schema = "SYSTEM")]
    public class MiembroEquipo
    {
        [Column("ID_MIEMBRO")]
        public long IdMiembro { get; set; }

        [Column("ID_EQUIPO")]
        public long IdEquipo { get; set; }

        [Column("NOMBRE_MIEMBRO")]
        public string NombreMiembro { get; set; } = string.Empty;

        [Column("EDAD")]
        public int Edad { get; set; }

        [Column("ESTILO")]
        public string Estilo { get; set; } = string.Empty;

        [Column("TIEMPO_MEJOR")]
        public string TiempoMejor { get; set; } = string.Empty;

        [ForeignKey("IdEquipo")]
        public EquipoNatacion Equipo { get; set; } = null!;
    }
}
