/// <summary>
/// Summary description for PhotoAlbumPosition
/// </summary>

namespace Developer.Position
{
    public class PhotoAlbumPosition
    {
        private string[] values;
        private string[] text;

        public PhotoAlbumPosition()
        {
            text = new string[]{"Nhóm hình ảnh trang chủ"};
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
