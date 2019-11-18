using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

namespace TatThanhJsc
{
    /// <summary>
    /// Summary description for PhotoAlbumExtension
    /// </summary>
    public class PhotoAlbumExtension
    {
        /// <summary>
        /// Đếm số hình ảnh trong một album
        /// </summary>
        /// <param name="iid"></param>
        /// <returns></returns>
        public static string CountSubItems(string iid)
        {
            string condition = DataExtension.AndConditon(
                SubitemsTSql.GetSubitemsByIid(iid),
                SubitemsTSql.GetSubitemsByIsenable("1"),
                SubitemsTSql.GetSubitemsByVskey(TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbumImagesOther));
            DataTable dt = new DataTable();
            dt = Subitems.GetSubItems("", SubitemsColumns.IsidColumn, condition, "");
            return NumberExtension.FormatNumber(dt.Rows.Count.ToString());
        }
    }
}