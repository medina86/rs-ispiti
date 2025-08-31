using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services;

namespace eCommerce.WebAPI.Controllers
{
    public class ToDoController: BaseCRUDController<ToDoResponse, ToDoSearchObject, ToDoRequest, ToDoRequest>
    {
        public ToDoController(IToDoService service): base(service)
        {

        }
    }
}
