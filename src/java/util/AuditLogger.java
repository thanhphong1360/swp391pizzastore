package util;

import dal.AuditLogDAO;
import model.AuditLog;

public class AuditLogger {

    private static final AuditLogDAO logDAO = new AuditLogDAO();

    public static void log(Integer userId, String action, String table, Integer targetId, String desc) {
        if (userId == null) userId = 0; 
        AuditLog log = new AuditLog();
        log.setUserId(userId);
        log.setActionType(action);
        log.setTargetTable(table);
        log.setTargetId(targetId);
        log.setDescription(desc);

        logDAO.insert(log);
    }
}
