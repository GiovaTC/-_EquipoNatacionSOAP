using Microsoft.EntityFrameworkCore;
using EquipoNatacionService.Models;

namespace EquipoNatacionService.Data
{
    public class OracleDbContext : DbContext
    {
        public OracleDbContext(DbContextOptions<OracleDbContext> options) : base(options) { }

        public DbSet<EquipoNatacion> Equipos { get; set; }
        public DbSet<MiembroEquipo> Miembros { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // ✅ Esquema especificado correctamente para Oracle
            modelBuilder.Entity<EquipoNatacion>(entity =>
            {
                entity.ToTable("EQUIPO_NATACION", schema: "APP");
                entity.HasKey(e => e.IdEquipo);
                entity.Property(e => e.IdEquipo).HasColumnName("ID_EQUIPO");
                entity.Property(e => e.NombreEquipo).HasColumnName("NOMBRE_EQUIPO").HasMaxLength(100);
                entity.Property(e => e.Entrenador).HasColumnName("ENTRENADOR").HasMaxLength(100);
                entity.Property(e => e.Ciudad).HasColumnName("CIUDAD").HasMaxLength(100);
                entity.Property(e => e.CantidadMiembros).HasColumnName("CANTIDAD_MIEMBROS");
                entity.Property(e => e.FechaRegistro).HasColumnName("FECHA_REGISTRO");
            });

            modelBuilder.Entity<MiembroEquipo>(entity =>
            {
                entity.ToTable("MIEMBRO_EQUIPO", schema: "APP");
                entity.HasKey(m => m.IdMiembro);
                entity.Property(m => m.IdMiembro).HasColumnName("ID_MIEMBRO");
                entity.Property(m => m.Nombre).HasColumnName("NOMBRE").HasMaxLength(100);
                entity.Property(m => m.Edad).HasColumnName("EDAD");
                entity.Property(m => m.Estilo).HasColumnName("ESTILO").HasMaxLength(50);
                entity.Property(m => m.TiempoMejor).HasColumnName("TIEMPO_MEJOR").HasMaxLength(10);
            });
        }
    }
}
