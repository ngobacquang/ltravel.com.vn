namespace Developer.Position
{
    public class CruisesPosition
    {
        private string[] values;
        private string[] text;

        public CruisesPosition()
        {
            text = new string[]
            {
                "Nhóm cruises trang chủ"
                , "Nhóm cruises bên phải web"
            };
            values = new string[]
            {
                "0"
                , "1"
            };
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
