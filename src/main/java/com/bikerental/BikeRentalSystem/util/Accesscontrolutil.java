package com.bikerental.BikeRentalSystem.util;

import com.bikerental.BikeRentalSystem.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Stateless helper for role-based access control in servlets.
 *
 * Usage pattern:
 *   if (!AccessControlUtil.requireLogin(request, response))                  return;
 *   if (!AccessControlUtil.requireRole(AppConstants.ROLE_ADMIN, req, res))   return;
 *   if (!AccessControlUtil.requireAdmin(request, response))                   return;
 *   if (!AccessControlUtil.requireSellerOrAdmin(request, response))           return;
 *
 * Every guard writes the flash-error to the session before redirecting,
 * so navbar.jsp displays the banner automatically on the next page.
 */
public final class AccessControlUtil {

    private AccessControlUtil() {}

    // ── Internals ────────────────────────────────────────────────────────────

    public static User getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute(AppConstants.SESSION_USER);
    }

    public static void setFlashError(HttpServletRequest req, String message) {
        req.getSession(true).setAttribute(AppConstants.SESSION_FLASH_ERROR, message);
    }

    public static void setFlashSuccess(HttpServletRequest req, String message) {
        req.getSession(true).setAttribute(AppConstants.SESSION_FLASH_SUCCESS, message);
    }

    // ── Guards ───────────────────────────────────────────────────────────────

    public static boolean requireLogin(HttpServletRequest req,
                                       HttpServletResponse res) throws IOException {
        if (getUser(req) == null) {
            res.sendRedirect(req.getContextPath() + AppConstants.ROUTE_LOGIN);
            return false;
        }
        return true;
    }

    public static boolean requireRole(String requiredRole,
                                      HttpServletRequest req,
                                      HttpServletResponse res) throws IOException {
        User user = getUser(req);
        if (user == null) {
            res.sendRedirect(req.getContextPath() + AppConstants.ROUTE_LOGIN);
            return false;
        }
        if (!requiredRole.equals(user.getRole())) {
            setFlashError(req, "Access denied: " + requiredRole + " role required.");
            res.sendRedirect(req.getContextPath() + AppConstants.ROUTE_HOME);
            return false;
        }
        return true;
    }

    public static boolean requireAnyRole(HttpServletRequest req,
                                         HttpServletResponse res,
                                         String... roles) throws IOException {
        User user = getUser(req);
        if (user == null) {
            res.sendRedirect(req.getContextPath() + AppConstants.ROUTE_LOGIN);
            return false;
        }
        for (String r : roles) {
            if (r.equals(user.getRole())) return true;
        }
        setFlashError(req, "Access denied: insufficient permissions.");
        res.sendRedirect(req.getContextPath() + AppConstants.ROUTE_HOME);
        return false;
    }

    // ── Convenience shorthands ───────────────────────────────────────────────

    public static boolean requireAdmin(HttpServletRequest req,
                                       HttpServletResponse res) throws IOException {
        return requireLogin(req, res)
                && requireRole(AppConstants.ROLE_ADMIN, req, res);
    }

    public static boolean requireSellerOrAdmin(HttpServletRequest req,
                                               HttpServletResponse res) throws IOException {
        return requireLogin(req, res)
                && requireAnyRole(req, res, AppConstants.ROLE_SELLER, AppConstants.ROLE_ADMIN);
    }
}