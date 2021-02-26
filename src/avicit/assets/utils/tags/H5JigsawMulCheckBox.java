package avicit.assets.utils.tags;

import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.spring.SpringFactory;
import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

public class H5JigsawMulCheckBox extends TagSupport {
    private static final long serialVersionUID = 56100714168265389L;
    private String id;
    private String name;
    private String lookupCode;
    private boolean isNull;
    private String title;
    private String defaultValue;
    private String canUse;
    private String css_class = "checkbox-inline";
    private String CLASS;
    private PageContext pageContext;
    private String formatCheck = "<input name=\"%s\" title=\"%s\" type=\"checkbox\" value=\"%s\" %s/>%s";

    public H5JigsawMulCheckBox() {
    }

    private SysLookupAPI getSysLookupAPI() {
        return H5JigsawMulCheckBox._c._lookupApi;
    }

    public int doStartTag() throws JspException {
        JspWriter out = this.pageContext.getOut();
        ServletRequest request = this.pageContext.getRequest();
        String languageCode = "zh_CN";
        if (request instanceof HttpServletRequest) {
            Cookie[] cookies = ((HttpServletRequest)request).getCookies();
            if (cookies != null && cookies.length > 0) {
                for(int i = 0; i < cookies.length; ++i) {
                    Cookie sCookie = cookies[i];
                    if ("P_L_CODE".equals(sCookie.getName())) {
                        languageCode = sCookie.getValue();
                        break;
                    }
                }
            }
        } else {
            Object obj = this.pageContext.getSession().getAttribute("CURRENT_LANGUAGE");
            if (obj != null) {
                languageCode = obj.toString();
            }
        }

        try {
            Collection<SysLookupSimpleVo> values = this.getSysLookupAPI().getLookUpListByTypeByAppIdWithLg(this.getLookupCode(), RestClientConfig.systemid, languageCode);
            if (this.getIsNull()) {
                this.getSysLookupAPI().enhanceLookupcode(values);
            }

            String mid;
            if (this.getId() == null) {
                mid = this.getName();
            } else {
                mid = this.getId();
            }

            if (this.getTitle() == null) {
                this.setTitle(this.getName());
            }

            StringBuffer sb = new StringBuffer();
            sb.append("<div id=\""+ mid +"CheckboxDiv\" style=\"position:absolute; display:none; z-index:100; background-color:#DCDCDC; overflow:auto;\">");

            for(Iterator var7 = values.iterator(); var7.hasNext(); sb.append("</label>")) {
                SysLookupSimpleVo vo = (SysLookupSimpleVo)var7.next();
                if (this.getCanUse().equals("1")) {
                    sb.append(String.format("<label class=\"%s\" id=\"%s\" title=\"%s\" disabled>", this.getCss_class(), (mid+'1'), this.getTitle()));
                } else {
                    sb.append(String.format("<label class=\"%s\" id=\"%s\" title=\"%s\"> ", this.getCss_class(), (mid+'1'), this.getTitle()));
                }

                if (null != this.getDefaultValue()) {
                    if (this.getDefaultValue().length() > 1) {
                        String[] defaultstr = this.getDefaultValue().split(",");
                        int i = 0;
                        String[] var11 = defaultstr;
                        int var12 = defaultstr.length;

                        for(int var13 = 0; var13 < var12; ++var13) {
                            String str = var11[var13];
                            ++i;
                            if (i == defaultstr.length && !vo.getLookupCode().equals(str)) {
                                sb.append(String.format(this.formatCheck, this.getName(), this.getTitle(), vo.getLookupCode(), "", vo.getLookupName()));
                            }

                            if (vo.getLookupCode().equals(str)) {
                                sb.append(String.format(this.formatCheck, this.getName(), this.getTitle(), vo.getLookupCode(), "checked", vo.getLookupName()));
                                break;
                            }
                        }
                    } else if (vo.getLookupCode().equals(this.getDefaultValue())) {
                        sb.append(String.format(this.formatCheck, this.getName(), this.getTitle(), vo.getLookupCode(), "checked", vo.getLookupName()));
                    } else {
                        sb.append(String.format(this.formatCheck, this.getName(), this.getTitle(), vo.getLookupCode(), "", vo.getLookupName()));
                    }
                } else {
                    sb.append(String.format(this.formatCheck, this.getName(), this.getTitle(), vo.getLookupCode(), "", vo.getLookupName()));
                }
            }

            sb.append("</div>");
            out.print(sb.toString());
        } catch (IOException var15) {
            var15.printStackTrace();
        }

        return super.doStartTag();
    }

    public int doEndTag() throws JspException {
        return 6;
    }

    public void release() {
        super.release();
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public PageContext getPageContext() {
        return this.pageContext;
    }

    public void setPageContext(PageContext pageContext) {
        this.pageContext = pageContext;
    }

    public String getLookupCode() {
        return this.lookupCode;
    }

    public void setLookupCode(String lookupCode) {
        this.lookupCode = lookupCode;
    }

    public boolean getIsNull() {
        return this.isNull;
    }

    public void setIsNull(boolean isNull) {
        this.isNull = isNull;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDefaultValue() {
        return this.defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getCanUse() {
        return this.canUse;
    }

    public void setCanUse(String canUse) {
        this.canUse = canUse;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCss_class() {
        return this.css_class;
    }

    public void setCss_class(String css_class) {
        this.css_class = css_class;
    }

    public String getCLASS() {
        return this.CLASS;
    }

    public void setCLASS(String cLASS) {
        this.CLASS = cLASS;
    }

    private static class _c {
        private static SysLookupAPI _lookupApi = (SysLookupAPI)SpringFactory.getBean(SysLookupAPI.class);

        private _c() {
        }
    }
}

