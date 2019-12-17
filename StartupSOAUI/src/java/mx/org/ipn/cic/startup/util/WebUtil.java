package mx.org.ipn.cic.startup.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class WebUtil {

    public static Object getBean(String beanName, HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        ServletContext servletContext = httpSession.getServletContext();
        WebApplicationContext webApplicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
        Object object = webApplicationContext.getBean(beanName);

        return object;
    }

    public static String getRealPath(String path, HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        ServletContext servletContext = httpSession.getServletContext();
        String realPath = servletContext.getRealPath(path);

        return realPath;
    }

    public static String getMimeType(String name, HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        ServletContext context = httpSession.getServletContext();
        String mimeType = context.getMimeType(name);

        return mimeType;
    }
}
