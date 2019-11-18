using System;
using System.Data;
using TatThanhJsc.BlogModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

/// <summary>
/// Xử lý các phần hiển thị, các thao tác khác liên quan tới blog
/// </summary>
public class BlogExtension
{
    /// <summary>
    /// Hiển thị ra nút share theo từng sản phẩm
    /// </summary>
    /// <param name="dr"></param>
    /// <returns></returns>
    public static string GetShareButton(DataRow dr)
    {
        string link = (UrlExtension.WebisteUrl + dr[ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();

        #region imageShareSrc
        string imageShareSrc = GetImageShareSrc(dr[ItemsColumns.ViimageColumn].ToString(),
                    dr[ItemsColumns.VicontentColumn].ToString());
        #endregion

        #region titleTagContent
        string titleTagContent = dr[ItemsColumns.VISEOTITLEColumn].ToString().Replace("\"", "");
        if (titleTagContent == "")
            titleTagContent = dr[ItemsColumns.VititleColumn].ToString().Replace("\"", "");
        #endregion

        #region metaDescriptionTagContent
        string metaDescriptionTagContent = dr[ItemsColumns.VISEOMETADESCColumn].ToString().Replace("\"", "");
        if (metaDescriptionTagContent == "")
            metaDescriptionTagContent = dr[ItemsColumns.VidescColumn].ToString().Replace("\"", "");
        #endregion

        return "<div class='addthis_inline_share_toolbox_4o7e' data-url='" + link +
               @"' data-title='" + titleTagContent + @"' data-description='" + metaDescriptionTagContent + @"' data-media='" + imageShareSrc +
               @"'></div>";
    }


    /// <summary>
    /// Lấy đường dẫn tới ảnh nếu image trống sẽ lấy ảnh đầu tiên trong nội dung
    /// </summary>    
    /// <param name="image"></param>
    /// <param name="content"></param>
    /// <returns></returns>
    public static string GetImageShareSrc(string image, string content)
    {
        string pic = FolderPic.Blog;
        if (image.Length < 1)
            return ImagesExtension.GetFirstImageInContent(content);
        else
            return UrlExtension.WebisteUrl + pic + "/" + image;
    }

    /// <summary>
    /// Hiển thị ra một blog ở trang danh sách bao gồm các thông tin như tiêu đề, ngày đăng, mô tả, ảnh đại diện...
    /// </summary>
    /// <returns></returns>
    public static string ShowABlog(DataRow dr)
    {
        string pic = FolderPic.Blog;
        string link =
            (UrlExtension.WebisteUrl + dr[ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();

        return @"
<div class='item'>
    <div class='topInfo'>
        <div class='date'><span>" + ((DateTime)dr[ItemsColumns.DicreatedateColumn]).ToString("dd") + @"</span>" + ((DateTime)dr[ItemsColumns.DicreatedateColumn]).ToString("MMM yyyy").ToUpper() + @"</div>
        <div class='titleAndAuthor'>
            <a href='" + link + "' class='title' title='" + dr[ItemsColumns.VititleColumn] + @"'>
                " + dr[ItemsColumns.VititleColumn] + @"
            </a><br/>
            <div class='author'>
                <i class='fa fa-user'></i> " + LanguageItemExtension.GetnLanguageItemTitleByName("Author") + @": " + dr[ItemsColumns.ViauthorColumn] + @"&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<i class='fa fa-comment'></i> "+CountComment(dr[ItemsColumns.IidColumn].ToString()) +@" " + LanguageItemExtension.GetnLanguageItemTitleByName("Comments") + @"
            </div>
        </div>
        <div class='cb'></div>
    </div>
    <div class='khungAnh'>        
        <a class='khungAnhCrop' href='" + link + @"'>
            " + ImagesExtension.GetImage(pic, dr[ItemsColumns.ViimageColumn].ToString(), dr[ItemsColumns.VititleColumn].ToString(), "", true, true, dr[ItemsColumns.VicontentColumn].ToString()) + @"                
        </a>        
    </div>
    <div class='desc'>
        " + dr[ItemsColumns.VidescColumn] + @"
    </div>
    <a href='" + link + @"' class='detail'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Read more") + @"</a><br/>
    <div class='shareButtons'>
        " + GetShareButton(dr) + @"
    </div>
    <div class='cb'><!----></div>
    <div class='cate_tags'>
        <div class='cate'><i class='fa fa-folder'></i>&nbsp;"+(dr[GroupsColumns.VgappColumn].ToString()!=TatThanhJsc.OtherModul.CodeApplications.Tag? "<a href='" + (UrlExtension.WebisteUrl + dr[GroupsColumns.VGSEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower() + @"' title='" + dr[GroupsColumns.VgnameColumn] + @"'>" + dr[GroupsColumns.VgnameColumn] + @"</a>" : GetCateOfBlog(dr[ItemsColumns.IidColumn].ToString()))+@"</div>
        <div class='tags'><i class='fa fa-tags'></i>&nbsp;
            "+ShowTags(dr[ItemsColumns.IidColumn].ToString()) +@"
        </div>
        <div class='cb'><!----></div>        
    </div>
</div>";
       
    }

    private static string GetCateOfBlog(string iid)
    {
        string condition = DataExtension.AndConditon(
            GroupsTSql.GetByApp(TatThanhJsc.BlogModul.CodeApplications.Blog),
            ItemsTSql.GetById(iid)
            );
        DataTable dt = GroupsItems.GetAllData("1", "*", condition, "");
        if (dt.Rows.Count > 0)
            return "<a href='" + (UrlExtension.WebisteUrl + dt.Rows[0][GroupsColumns.VGSEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower() + @"' title='" + dt.Rows[0][GroupsColumns.VgnameColumn] + @"'>" + dt.Rows[0][GroupsColumns.VgnameColumn] + @"</a>";

        return "";
    }

    /// <summary>
    /// Hiện thị các tag cho 1 blog
    /// </summary>
    /// <param name="iid"></param>
    /// <returns></returns>
    private static string ShowTags(string iid)
    {
        string s = "";

        string condition = DataExtension.AndConditon(
            GroupsItemsTSql.GetGroupsItemsByIid(iid), 
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.OtherModul.CodeApplications.Tag));
        DataTable dt = GroupsItems.GetAllData("", "groups.*", condition, GroupsColumns.IgorderColumn);

        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                s += "<a href='" + (UrlExtension.WebisteUrl + RewriteExtension.Tag + "/" + dt.Rows[i][GroupsColumns.VGSEOLINKSEARCHColumn]+RewriteExtension.Extensions).ToLower() + "' title='" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"'>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</a>, ";
            }
            s = s.Remove(s.Length - ", ".Length);
        }
        return s;
    }

    /// <summary>
    /// Đếm comment cho một blog
    /// </summary>
    /// <param name="iid"></param>
    /// <returns></returns>
    public static string CountComment(string iid)
    {
        string app = TatThanhJsc.BlogModul.CodeApplications.BlogComment;
        string condition = DataExtension.AndConditon(
           SubitemsTSql.GetByIid(iid),
           SubitemsTSql.GetByApp(app),
           SubitemsTSql.GetByEnable("1")
           );
        DataTable dt = Subitems.GetSubItems("", SubitemsColumns.IsidColumn, condition, "");
        return NumberExtension.FormatNumber(dt.Rows.Count.ToString());
    }
}