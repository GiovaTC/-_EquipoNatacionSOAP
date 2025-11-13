using Microsoft.EntityFrameworkCore;
using EquipoNatacionService.Models;

namespace EquipoNatacionService.Data
{
    public class OracleDbContext : DbContext
    {
        public OracleDbContext(DbContextOptions<OracleDbContext> options)
            : base(options)
        {
        }

        // Tablas del esquema SYSTEM
        public DbSet<EquipoNatacion> Equipos { get; set; }
        public DbSet<MiembroEquipo> Miembros { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // ==========================
            // 🏊 EQUIPO_NATACION
            // ==========================
            modelBuilder.Entity<EquipoNatacion>(entity =>
            {
                entity.ToTable("EQUIPO_NATACION", schema: "SYSTEM");

                entity.HasKey(e => e.IdEquipo);

                entity.Property(e => e.IdEquipo)
                    .HasColumnName("ID_EQUIPO");

                entity.Property(e => e.NombreEquipo)
                    .HasColumnName("NOMBRE_EQUIPO")
                    .HasMaxLength(100);

                entity.Property(e => e.Entrenador)
                    .HasColumnName("ENTRENADOR")
                    .HasMaxLength(100);

                entity.Property(e => e.Ciudad)
                    .HasColumnName("CIUDAD")
                    .HasMaxLength(100);

                entity.Property(e => e.CantidadMiembros)
                    .HasColumnName("CANTIDAD_MIEMBROS");

                entity.Property(e => e.FechaRegistro)
                    .HasColumnName("FECHA_REGISTRO")
                    .HasDefaultValueSql("SYSDATE");

                // Relación 1:N con MIEMBRO_EQUIPO
                entity.HasMany(e => e.Miembros)
                      .WithOne(m => m.Equipo)
                      .HasForeignKey(m => m.IdEquipo)
                      .OnDelete(DeleteBehavior.Cascade);
            });

            // ==========================
            // 🧍 MIEMBRO_EQUIPO
            // ==========================
            modelBuilder.Entity<MiembroEquipo>(entity =>
            {
                entity.ToTable("MIEMBRO_EQUIPO", schema: "SYSTEM");

                entity.HasKey(m => m.IdMiembro);

                entity.Property(m => m.IdMiembro)
                      .HasColumnName("ID_MIEMBRO");

                entity.Property(m => m.IdEquipo)
                      .HasColumnName("ID_EQUIPO");

                entity.Property(m => m.NombreMiembro)
                      .HasColumnName("NOMBRE_MIEMBRO")
                      .HasMaxLength(100);

                entity.Property(m => m.Edad)
                      .HasColumnName("EDAD");

                entity.Property(m => m.Estilo)
                      .HasColumnName("ESTILO")
                      .HasMaxLength(50);

                entity.Property(m => m.TiempoMejor)
                      .HasColumnName("TIEMPO_MEJOR")
                      .HasMaxLength(10);
            });
        }
    }
}
