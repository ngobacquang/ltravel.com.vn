/// <summary>
/// Summary description for BlogsPosition
/// </summary>

namespace Developer.Position
{
    public class BlogPosition
    {
        private string[] values;
        private string[] text;

        public BlogPosition()
        {
            text = new string[]{"Blog mới nhất","Blog xem nhiều nhất"};
            values = new string[] {"0","1"};
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
