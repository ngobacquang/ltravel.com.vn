/// <summary>
/// Summary description for CustomerPosition
/// </summary>

namespace Developer.Position
{
    public class CustomerPosition
    {
        private string[] values;
        private string[] text;

        public CustomerPosition()
        {
            text = new string[] { "Nhóm thi công nội thất tại trang chủ", "Nhóm thi công nội thất bên phải web" };
            values = new string[] {"0", "1"};
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
