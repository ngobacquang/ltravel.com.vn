using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ContentPosition
/// </summary>

namespace Developer.Position
{
    public class PsgPosition
    {
        private string[] values;
        private string[] text;

        public PsgPosition()
        {
            text = new string[]{"Thông tin liên hệ dưới Footer","Our Missions - Footer","Tại sao chọn chúng tôi - Footer","Bài viết đầu trang giới thiệu"};
            values = new string[] {"1","2","3","4"};
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
