
using System;
using System.Data;
using System.Data.OleDb;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.TSql;

namespace TatThanhJsc.Extension
{
    public class TourExtension
    {
        
        /// <summary>
        /// Lấy điều kiện tìm tour theo địa điểm (ví dụ truyền vào id của Việt Nam thì sẽ tìm tất cả các tour ở các tỉnh thành thuộc Việt Nam)
        /// </summary>
        /// <param name="igid"></param>
        /// <returns></returns>
        public static string LayDieuKienTheoDiaDiem(string igid)
        {
            string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
            string s = "";
            string condition = DataExtension.AndConditon(
                GroupsTSql.GetGroupsByVgapp(TatThanhJsc.DestinationModul.CodeApplications.Destination),
                GroupsTSql.GetGroupsByIgenable("1"),
                GroupsTSql.GetGroupsByVglang(lang),
                "charindex('," + igid + ",',IGPARENTSID)>0"
                );
            DataTable dt = Groups.GetGroups("", GroupsColumns.IgidColumn, condition, "");
            //Lấy danh sách id của các địa điểm con, ví dụ tìm theo id của Việt Nam thì sẽ phải tìm được cả các tour thuộc Hà Nội, Sapa, TP HCM...
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    s += dt.Rows[i][GroupsColumns.IgidColumn] + ",";
                }
            }
            else
                s = igid;

            //Điều kiện nếu danh sách id của tour có giao với danh sách id của địa điểm đang tìm
            return "dbo.ContainsSharedTerm(replace(viurl,'-',','),'" + s + "')=1";
        }

        /// <summary>
        /// Hiển thị thời gian tour dạng 2 ngày / 1 đêm.
        /// </summary>
        /// <param name="duration">Ví dụ duration là 2-1 thì kết quả là 2 ngày / 1 đêm</param>
        /// <returns></returns>
        public static string ShowTourDuration(string duration)
        {
            string s = "";
            try
            {
                s = duration.Remove(duration.IndexOf("-")) + " " +
                    LanguageItemExtension.GetnLanguageItemTitleByName("days");
                s += " / ";
                s += duration.Substring(duration.IndexOf("-") + 1) + " " +
                     LanguageItemExtension.GetnLanguageItemTitleByName("nights");
            }
            catch{}

            return s;
        }

        public static string GetPropertyIcon(string iid, string propertyApp, string pic)
        {
            string s = "";
            string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
            string condition = DataExtension.AndConditon(
                GroupsTSql.GetByApp(propertyApp),
                GroupsTSql.GetByEnable("1"),
                GroupsTSql.GetByLang(lang),
                ItemsTSql.GetItemsByIid(iid));

            DataTable dt = GroupsItems.GetAllData("", GroupsColumns.VgimageColumn + "," + GroupsColumns.VgnameColumn,
                condition, GroupsColumns.IgorderColumn);
            if(dt.Rows.Count>0)
            {
                s += "<span class='propertyIcons'>";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    s += ImagesExtension.GetImage(pic, dt.Rows[i][GroupsColumns.VgimageColumn].ToString(),
                        dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), "propertyIcon", false, false, "");
                }
                s += "</span>";
            }

            return s;
        }

        /// <summary>
        /// Lấy trạng thái thanh toán. 0: Đang chờ; 1: Thành công; 2: Đã hủy; -1: Không thành công, còn lại là Chưa xác định
        /// </summary>
        /// <param name="trangthaithanhtoan"></param>
        /// <returns></returns>
        public static string LayTrangThaiThanhToan(string trangthaithanhtoan)
        {
            if (trangthaithanhtoan == "1")
                return "Succeeded";

            if (trangthaithanhtoan == "0")
                return "Pending";

            if (trangthaithanhtoan == "2")
                return "Cancelled";

            if (trangthaithanhtoan == "-1")
                return "Unsuccessful";

            return "Undefined";
        }

        public static string LayPhuongThucThanhToan(string phuongthucthanhtoan)
        {
            if (phuongthucthanhtoan == "ThanhToanSau")
                return "Customers need more advice - Will pay later (Khách hàng cần tư vấn - Sẽ thanh toán sau)";

            if (phuongthucthanhtoan == "ChuyenKhoan")
                return "Payment via bank card - Chuyển khoản";

            if (phuongthucthanhtoan == "Onepay")
                return "Online payment by ATM card";

            if (phuongthucthanhtoan == "OnepayQuocTe")
                return "Online payment by Visa, Master, American Express,...";

            return "Undefined";
        }

        /// <summary>
        /// Sinh mã đơn hàng khi đặt tour
        /// </summary>
        /// <param name="iid">id tour</param>
        /// <param name="email">Email người đặt</param>
        /// <returns></returns>
        public static string SinhMaDonHang(string iid, string email)
        {
            return SecurityExtension.BuildPassword(iid + "_" + email + "_" + DateTime.Now.Ticks);
        }
    }
}