using eCommerce.Model.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class ToDoSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public DateTime? Rok {  get; set; }
        public StatusAktivnosti? Status{ get; set; }
    }
}
