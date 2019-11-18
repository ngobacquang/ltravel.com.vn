/// <summary>
/// Summary description for ProductPosition
/// </summary>

namespace Developer.Position
{
    public class ProductPosition
    {
        private string[] values;
        private string[] text;

        public ProductPosition()
        {
            text = new string[]{"Nhóm các danh mục du học trang chủ"};
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
