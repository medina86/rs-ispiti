using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;
using Mapster;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services
{
    public class ToDoService : BaseCRUDService<ToDoResponse, ToDoSearchObject, Database.ToDo4924, ToDoRequest, ToDoRequest>, IToDoService
    {
        public ToDoService(eCommerceDbContext context, IMapper mapper): base(context,mapper) { }

        protected override Task BeforeInsert(ToDo4924 entity, ToDoRequest request)
        {
            entity.Status = Model.Enums.StatusAktivnosti.UToku;
            return base.BeforeInsert(entity, request);
        }
        protected override  IQueryable<ToDo4924> ApplyFilter(IQueryable<ToDo4924> query, ToDoSearchObject search)
        {
            if(search.UserId!=null)
            {
                query=query.Where(x=>x.UserId==search.UserId);
            }
            if (search.Rok != null)
            {
                query = query.Where(x => x.Rok <= search.Rok);
            }
            if (search.Status != null)
            {
                query = query.Where(x => x.Status == search.Status);
            }
            return base.ApplyFilter(query, search);
        }
    }
}
