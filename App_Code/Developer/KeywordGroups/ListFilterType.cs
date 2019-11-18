using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TatThanhJsc.KeywordGroups
{
    public class ListFilterType
    {
        private string[] values;
        private string[] text;

        public string ThuongHieu { get { return values[0]; } }
        public string KhoangGia { get { return values[1]; } }
        public string MauSac { get { return values[2]; } }
        public string KichCo { get { return values[3]; } }
        public string LoaiKhac { get { return values[4]; } }        

        public ListFilterType()
        {
            values = new string[] { "1","2","3","4","5" };
            text = new string[] { "Thương hiệu", "Khoảng giá", "Màu sắc", "Kích cỡ", "Loại khác" };
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