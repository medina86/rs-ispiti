using eCommerce.Model.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class ToDoResponse
    {
        public int Id { get; set; }
        public UserResponse User { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public DateTime Rok { get; set; }
        public StatusAktivnosti Status { get; set; }
    }
}
