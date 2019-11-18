/// <summary>
/// Summary description for NewsPosition
/// </summary>

namespace Developer.Position
{
    public class NewPosition
    {
        private string[] values;
        private string[] text;

        public NewPosition()
        {
            text = new string[]{"Nhóm tin tức du học trang chủ"};
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
