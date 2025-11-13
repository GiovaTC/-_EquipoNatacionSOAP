using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using EquipoNatacionService.Models;

namespace EquipoNatacionService.Utils
{
    public static class XmlParser
    {
        // =====================================
        // 📥 Convierte XML -> Objeto C#
        // =====================================
        public static EquipoNatacion ParseEquipo(string xmlDatos)
        {
            var doc = XDocument.Parse(xmlDatos);
            var root = doc.Element("EquipoNatacion");
            if (root == null)
                throw new Exception("El XML no contiene el nodo raíz 'EquipoNatacion'.");

            var equipo = new EquipoNatacion
            {
                NombreEquipo = (string?)root.Element("NombreEquipo") ?? string.Empty,
                Entrenador = (string?)root.Element("Entrenador") ?? string.Empty,
                Ciudad = (string?)root.Element("Ciudad") ?? string.Empty
            };

            var miembros = root.Element("Miembros")?.Elements("Miembro") ?? Enumerable.Empty<XElement>();
            foreach (var m in miembros)
            {
                var miembro = new MiembroEquipo
                {
                    NombreMiembro = (string?)m.Element("NombreMiembro") ?? string.Empty,
                    Edad = (int?)m.Element("Edad") ?? 0,
                    Estilo = (string?)m.Element("Estilo") ?? string.Empty,
                    TiempoMejor = (string?)m.Element("TiempoMejor") ?? string.Empty
                };
                equipo.Miembros.Add(miembro);
            }

            equipo.CantidadMiembros = equipo.Miembros.Count;
            return equipo;
        }

        // =====================================
        // 📤 Convierte Objeto C# -> XML
        // =====================================
        public static string ToXml(EquipoNatacion equipo)
        {
            var doc = new XElement("EquipoNatacion",
                new XElement("NombreEquipo", equipo.NombreEquipo),
                new XElement("Entrenador", equipo.Entrenador),
                new XElement("Ciudad", equipo.Ciudad),
                new XElement("CantidadMiembros", equipo.CantidadMiembros),
                new XElement("FechaRegistro", equipo.FechaRegistro.ToString("yyyy-MM-dd")),
                new XElement("Miembros",
                    from m in equipo.Miembros
                    select new XElement("Miembro",
                        new XElement("NombreMiembro", m.NombreMiembro),
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
