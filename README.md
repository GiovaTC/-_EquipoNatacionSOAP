# -_EquipoNatacionSOAP

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/31e21391-810e-46c7-8bab-10a3f3c7319a" />  

Servicio SOAP en **.NET 8.0** para registrar y consultar equipos de natación.  
Este repositorio contiene:

- Código fuente completo (C#) del servicio SOAP.
- Scripts SQL para Oracle 19c.
- XML de ejemplo (259 líneas) con datos ficticios de un equipo.
- Instrucciones para ejecutar y probar localmente.

---

## Contenido del proyecto

```
EquipoNatacionSOAP/
├─ EquipoNatacionService/
│  ├─ Program.cs
│  ├─ EquipoNatacionService.csproj
│  ├─ Services/EquipoService.cs
│  ├─ Models/EquipoNatacion.cs
│  ├─ Data/OracleDbContext.cs
│  ├─ Utils/XmlParser.cs
│  ├─ appsettings.json
├─ db/ScriptTablasOracle.sql
├─ samples/ejemplo_equipo_259_lineas.xml
└─ README.md
```

A continuación se incluye **todo** el código fuente y archivos importantes para que puedas verlos directamente en GitHub.

## Program.cs

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SoapCore;
using EquipoNatacionSOAP.Services;
using EquipoNatacionSOAP.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configure EF Core with Oracle (connection string in appsettings.json)
builder.Services.AddDbContext<OracleDbContext>(options =>
    options.UseOracle(builder.Configuration.GetConnectionString("OracleConnection"))
);

// Register SOAP service
builder.Services.AddSingleton<IEquipoService, EquipoService>();

var app = builder.Build();

app.UseRouting();
app.UseSwagger();
app.UseSwaggerUI();

app.UseEndpoints(endpoints =>
{
    endpoints.UseSoapEndpoint<IEquipoService>("/Service.svc", new SoapCore.SoapEncoderOptions(), SoapCore.SoapSerializer.XmlSerializer);
    endpoints.MapControllers();
});

app.Run();

```

## EquipoNatacionService.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="SoapCore" Version="1.1.0" />
    <PackageReference Include="Oracle.ManagedDataAccess.Core" Version="3.21.1" />
    <PackageReference Include="Microsoft.EntityFrameworkCore" Version="8.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="8.0.0" />
    <PackageReference Include="Oracle.EntityFrameworkCore" Version="8.0.0" />
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
  </ItemGroup>

</Project>

```

## Services/EquipoService.cs

```csharp
using System.Linq;
using System.Xml.Linq;
using EquipoNatacionSOAP.Data;
using EquipoNatacionSOAP.Models;
using EquipoNatacionSOAP.Utils;
using Microsoft.EntityFrameworkCore;

namespace EquipoNatacionSOAP.Services
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

```

## Models/EquipoNatacion.cs

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace EquipoNatacionSOAP.Models
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

```

## Data/OracleDbContext.cs

```csharp
using Microsoft.EntityFrameworkCore;
using EquipoNatacionSOAP.Models;

namespace EquipoNatacionSOAP.Data
{
    public class OracleDbContext : DbContext
    {
        public OracleDbContext(DbContextOptions<OracleDbContext> options) : base(options) { }

        public DbSet<EquipoNatacion> Equipos { get; set; }
        public DbSet<MiembroEquipo> Miembros { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema("APP");
            modelBuilder.Entity<EquipoNatacion>(entity =>
            {
                entity.ToTable("EQUIPO_NATACION");
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
                entity.ToTable("MIEMBRO_EQUIPO");
                entity.HasKey(m => m.IdMiembro);
                entity.Property(m => m.IdMiembro).HasColumnName("ID_MIEMBRO");
                entity.Property(m => m.IdEquipo).HasColumnName("ID_EQUIPO");
                entity.Property(m => m.Nombre).HasColumnName("NOMBRE_MIEMBRO").HasMaxLength(100);
                entity.Property(m => m.Edad).HasColumnName("EDAD");
                entity.Property(m => m.Estilo).HasColumnName("ESTILO").HasMaxLength(50);
                entity.Property(m => m.TiempoMejor).HasColumnName("TIEMPO_MEJOR").HasMaxLength(10);
            });
        }
    }
}

```

## Utils/XmlParser.cs

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using EquipoNatacionSOAP.Models;
namespace EquipoNatacionSOAP.Utils
{
    public static class XmlParser
    {
        public static EquipoNatacion ParseEquipo(string xmlDatos)
        {
            var doc = XDocument.Parse(xmlDatos);
            var root = doc.Element("EquipoNatacion");
            var equipo = new EquipoNatacion
            {
                NombreEquipo = (string)root.Element("NombreEquipo"),
                Entrenador = (string)root.Element("Entrenador"),
                Ciudad = (string)root.Element("Ciudad")
            };

            var miembros = root.Element("Miembros")?.Elements("Miembro") ?? Enumerable.Empty<XElement>();
            foreach (var m in miembros)
            {
                var miembro = new MiembroEquipo
                {
                    Nombre = (string)m.Element("Nombre"),
                    Edad = (int?)m.Element("Edad") ?? 0,
                    Estilo = (string)m.Element("Estilo"),
                    TiempoMejor = (string)m.Element("TiempoMejor")
                };
                equipo.Miembros.Add(miembro);
            }
            equipo.CantidadMiembros = equipo.Miembros.Count;
            return equipo;
        }

        public static string ToXml(Models.EquipoNatacion equipo)
        {
            var doc = new XElement("EquipoNatacion",
                new XElement("NombreEquipo", equipo.NombreEquipo),
                new XElement("Entrenador", equipo.Entrenador),
                new XElement("Ciudad", equipo.Ciudad),
                new XElement("Miembros",
                    from m in equipo.Miembros
                    select new XElement("Miembro",
                        new XElement("Nombre", m.Nombre),
                        new XElement("Edad", m.Edad),
                        new XElement("Estilo", m.Estilo),
                        new XElement("TiempoMejor", m.TiempoMejor)
                    )
                )
            );
            return new XDocument(doc).ToString();
        }
    }
}

```

## appsettings.json

```json
{
  "ConnectionStrings": {
    "OracleConnection": "User Id=APP;Password=tu_password;Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=ORCLCDB)))"
  }
}
```

## db/ScriptTablasOracle.sql

```sql
-- Script de creación de tablas para Oracle 19c
CREATE TABLE APP.EQUIPO_NATACION (
    ID_EQUIPO NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    NOMBRE_EQUIPO VARCHAR2(100),
    ENTRENADOR VARCHAR2(100),
    CIUDAD VARCHAR2(100),
    CANTIDAD_MIEMBROS NUMBER,
    FECHA_REGISTRO DATE DEFAULT SYSDATE
);

CREATE TABLE APP.MIEMBRO_EQUIPO (
    ID_MIEMBRO NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    ID_EQUIPO NUMBER REFERENCES APP.EQUIPO_NATACION(ID_EQUIPO),
    NOMBRE_MIEMBRO VARCHAR2(100),
    EDAD NUMBER,
    ESTILO VARCHAR2(50),
    TIEMPO_MEJOR VARCHAR2(10)
);

-- Índices
CREATE INDEX IDX_EQUIPO_NOMBRE ON APP.EQUIPO_NATACION (NOMBRE_EQUIPO);

```

## samples/ejemplo_equipo_259_lineas.xml (líneas: 259)

```xml
<EquipoNatacion>
  <NombreEquipo>Delfines del Pacífico</NombreEquipo>
  <Entrenador>Juan Pérez</Entrenador>
  <Ciudad>Barranquilla</Ciudad>
  <Miembros>
    <Miembro>
      <Nombre>Camila López</Nombre>
      <Edad>28</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:59.82</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Mateo García</Nombre>
      <Edad>29</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:55.41</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Sofía Martínez</Nombre>
      <Edad>30</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:56.22</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Daniel Rodríguez</Nombre>
      <Edad>15</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:50.23</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Valentina Gómez</Nombre>
      <Edad>17</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:53.96</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Samuel Torres</Nombre>
      <Edad>24</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:52.55</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Isabella Castro</Nombre>
      <Edad>21</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:58.73</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Lucas Mendoza</Nombre>
      <Edad>15</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:51.42</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Mariana Ruiz</Nombre>
      <Edad>21</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:52.77</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Tomás Herrera</Nombre>
      <Edad>20</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:55.17</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Lucía Ramírez</Nombre>
      <Edad>30</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:52.22</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Gabriel Flores</Nombre>
      <Edad>19</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:55.47</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Ana Morales</Nombre>
      <Edad>20</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:56.27</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Diego Peña</Nombre>
      <Edad>23</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:54.36</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Laura Vargas</Nombre>
      <Edad>16</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:56.66</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Andrés Salazar</Nombre>
      <Edad>25</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:53.15</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Emma Rojas</Nombre>
      <Edad>29</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:50.15</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Juan Camacho</Nombre>
      <Edad>15</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:52.45</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Paula Ortega</Nombre>
      <Edad>25</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:54.30</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Fernando Díaz</Nombre>
      <Edad>21</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:58.59</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Carolina León</Nombre>
      <Edad>23</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:56.57</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Sergio Navarro</Nombre>
      <Edad>16</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:53.54</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Elena Cabrera</Nombre>
      <Edad>30</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:59.48</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Ricardo Pineda</Nombre>
      <Edad>20</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:55.66</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Olivia Bravo</Nombre>
      <Edad>16</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:55.83</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Miguel Suárez</Nombre>
      <Edad>16</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:57.34</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Natalia Fuentes</Nombre>
      <Edad>17</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:57.25</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Javier Márquez</Nombre>
      <Edad>23</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:51.85</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Marta Delgado</Nombre>
      <Edad>18</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:54.48</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Pablo Molina</Nombre>
      <Edad>15</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:59.44</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Camila López 31</Nombre>
      <Edad>15</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:52.23</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Mateo García 32</Nombre>
      <Edad>24</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:53.48</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Sofía Martínez 33</Nombre>
      <Edad>29</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:50.94</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Daniel Rodríguez 34</Nombre>
      <Edad>20</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:53.74</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Valentina Gómez 35</Nombre>
      <Edad>20</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:58.17</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Samuel Torres 36</Nombre>
      <Edad>29</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:59.65</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Isabella Castro 37</Nombre>
      <Edad>21</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:54.46</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Lucas Mendoza 38</Nombre>
      <Edad>15</Edad>
      <Estilo>Espalda</Estilo>
      <TiempoMejor>00:55.19</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Mariana Ruiz 39</Nombre>
      <Edad>24</Edad>
      <Estilo>Pecho</Estilo>
      <TiempoMejor>00:52.25</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Tomás Herrera 40</Nombre>
      <Edad>18</Edad>
      <Estilo>Combinado</Estilo>
      <TiempoMejor>00:58.20</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Lucía Ramírez 41</Nombre>
      <Edad>18</Edad>
      <Estilo>Crol</Estilo>
      <TiempoMejor>00:59.97</TiempoMejor>
    </Miembro>
    <Miembro>
      <Nombre>Gabriel Flores 42</Nombre>
      <Edad>19</Edad>
      <Estilo>Mariposa</Estilo>
      <TiempoMejor>00:50.11</TiempoMejor>
    </Miembro>
    <Miembro>
</EquipoNatacion>
```
:. . / .
