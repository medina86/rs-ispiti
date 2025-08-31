using eCommerce.Model.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class ToDo4924
    {
        public int Id { get; set; }
        public int UserId {  get; set; }
        [ForeignKey(nameof(UserId))]
        public User User { get; set; }
        public string Naziv {  get; set; }
        public string Opis { get; set; }
        public DateTime Rok { get; set; }
        public StatusAktivnosti Status {  get; set; }

    }
}
