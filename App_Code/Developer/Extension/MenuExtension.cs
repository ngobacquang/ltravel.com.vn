using System;
using System.Web;
using TatThanhJsc.Extension;

/// <summary>
/// Hỗ trợ các thao tác liên quan đến menu
/// </summary>
public class MenuExtension
{
    /// <summary>
    /// Trả về " target='_blank' " hoặc ""
    /// </summary>
    /// <param name="vgparrams"></param>
    /// <returns></returns>
    public static string GetTarget(string vgparrams)
    {
        if (StringExtension.LayChuoi(vgparrams, TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 2) == "1")
            return " target='_blank' ";
        else return "";
    }

    public static string GetIgidInVgdesc(string vgdesc)
    {
        string igidParrent = "";
        int index1 = vgdesc.IndexOf("igid=");
        if (index1 > -1)
        {
            index1 += "igid=".Length;
            int index2 = vgdesc.IndexOf("&", index1);
            if (index2 > -1)
                igidParrent = vgdesc.Substring(index1, index2 - index1);
            else
                igidParrent = vgdesc.Substring(index1);
        }
        if (igidParrent.Length < 1) igidParrent = "0";
        return igidParrent.Replace("#", "");
    }

    /// <summary>
    /// Trích thông tin ra theo kiểu QueryString
    /// </summary>
    /// <param name="info">Chuỗi chứa các QueryString</param>
    /// <param name="name">Tên QueryString cần lấy</param>
    /// <returns></returns>
    public static string GetQueryString(string info, string name)
    {
        string s = "";

        #region Trích thông tin ra theo kiểu QueryString

        //Lấy tất cả parram được post lên từ máy khách
        var myUrl = info;
        myUrl = HttpUtility.HtmlDecode(myUrl);
        //Chuyển về kiểu QueryString
        var values = HttpUtility.ParseQueryString(myUrl);
        //Lấy ra giá trị theo tên QueryString
        //var t = values["ExpiryDate"];
        var temp = "";

        if (values[name] != null)
        {
            temp = values[name];
            s = temp;
        }

        #endregion

        return s;
    }

   
    public static string GetUrl()
    {
        string s = "";

        s = (HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.RawUrl).ToLower();

        if (s.EndsWith("default.aspx?"))
            s = s.Remove(s.Length - "default.aspx?".Length);
        if (s.EndsWith("default.aspx"))
            s = s.Remove(s.Length - "default.aspx".Length);
        return s;
    }

}