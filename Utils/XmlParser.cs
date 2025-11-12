using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using EquipoNatacionService.Models;

namespace EquipoNatacionService.Utils
{
    public static class XmlParser
    {
        public static EquipoNatacion ParseEquipo(string xmlDatos)
        {
            var doc = XDocument.Parse(xmlDatos);
            var root = doc.Element("EquipoNatacion");
            var equipo =  new EquipoNatacion
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
