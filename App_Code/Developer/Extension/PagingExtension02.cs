using System;
using TatThanhJsc.Extension;

/// <summary>
/// Summary description for PagingExtension02
/// </summary>
public class PagingExtension02
{
    public static string XuLyPhanTrang(string split, string ni, string title, string dauText, string cuoiText, string truocText, string sauText)
    {
        string s = "";
        split = split.Replace("<div class='SplitPages'>", "").Replace("</div>", "");

        foreach (string a in split.Split(new string[] { "</a>" }, StringSplitOptions.RemoveEmptyEntries))
        {
            string tempA = a;

            if (tempA.IndexOf("dau")>-1)
                tempA = tempA.Replace("&nbsp;", dauText);

            if (tempA.IndexOf("cuoi") > -1)
                tempA = tempA.Replace("&nbsp;", cuoiText);

            if (tempA.IndexOf("truoc") > -1)
                tempA = tempA.Replace("&nbsp;", truocText);

            if (tempA.IndexOf("sau") > -1)
                tempA = tempA.Replace("&nbsp;", sauText);

            if (tempA.IndexOf("#")<0)
                s += (tempA.Replace("'>", ""+RewriteExtension.Extensions+"'>") + "</a>").Replace("href='&ni=" + ni + "&p=",
                    "href='" + UrlExtension.WebisteUrl + title + "/p-");
            else
                s += tempA + "</a>";
        }

        return "<div class='paging SplitPages'>" + s.Replace("/p-1","") + "</div>";
    }
}