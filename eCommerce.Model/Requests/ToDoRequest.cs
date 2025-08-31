using eCommerce.Model.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class ToDoRequest
    {
        public int UserId { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public DateTime Rok { get; set; }
        public StatusAktivnosti Status { get; set; }
    }
}
