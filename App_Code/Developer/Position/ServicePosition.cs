/// <summary>
/// Summary description for ServicePosition
/// </summary>

namespace Developer.Position
{
    public class ServicePosition
    {
        private string[] values;
        private string[] text;

        public ServicePosition()
        {
            text = new string[] { "Nhóm dịch vụ bên trái website" };
            values = new string[] {"0"};
        }
        public string[] Text
        {
            get { return text; }
        }
        public string[] Values
        {
            get { return values; }
        }
    }
}
