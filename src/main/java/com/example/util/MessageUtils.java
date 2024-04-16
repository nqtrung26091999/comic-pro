package com.example.util;

import java.util.HashMap;
import java.util.Map;

public class MessageUtils {
    public static Map<String, String> handleMessage(String msg) {
        Map<String, String> msgMap = new HashMap<>();
        switch (msg) {
            case "insert_success":
                msgMap.put("message", "Thêm mới thành công !");
                msgMap.put("alert", "success");
                break;
            case "update_success":
                msgMap.put("message", "Cập nhật thành công !");
                msgMap.put("alert", "success");
                break;
            case "insert_failed":
                msgMap.put("message", "Thêm mới thất bại !");
                msgMap.put("alert", "danger");
                break;
            case "update_failed":
                msgMap.put("message", "Cập nhật thất bại !");
                msgMap.put("alert", "danger");
                break;
            case "delete_success":
                msgMap.put("message", "Xóa thành công !");
                msgMap.put("alert", "success");
                break;
        }
        return msgMap;
    }
}
