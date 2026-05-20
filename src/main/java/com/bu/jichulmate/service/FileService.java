package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Attachment;
import com.bu.jichulmate.repository.AttachmentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FileService {

    private final AttachmentRepository attachmentRepository;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @Transactional
    public Attachment uploadFile(MultipartFile file, String refTable, Long refId) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }

        String contentType = file.getContentType();

        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IllegalArgumentException("이미지 파일만 업로드할 수 있습니다.");
        }

        String orgFileName = StringUtils.cleanPath(file.getOriginalFilename());

        if (orgFileName == null || orgFileName.isBlank()) {
            orgFileName = "upload-image";
        }

        String extension = "";
        int dotIndex = orgFileName.lastIndexOf(".");

        if (dotIndex >= 0) {
            extension = orgFileName.substring(dotIndex);
        }

        String savedFileName = UUID.randomUUID() + extension;
        String normalizedUploadDir = resolveUploadDir();

        File dest = new File(normalizedUploadDir + savedFileName);

        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }

        file.transferTo(dest);

        String filePath = "/images/" + savedFileName;

        Attachment attachment = Attachment.builder()
                .refTable(refTable)
                .refId(refId)
                .orgFileName(orgFileName)
                .savedFileName(savedFileName)
                .filePath(filePath)
                .fileSize(file.getSize())
                .regDate(LocalDateTime.now())
                .build();

        return attachmentRepository.save(attachment);
    }

    @Transactional
    public List<Attachment> uploadFiles(MultipartFile[] files, String refTable, Long refId) throws IOException {
        List<Attachment> result = new ArrayList<>();

        if (files == null || files.length == 0) {
            return result;
        }

        for (MultipartFile file : files) {
            if (file == null || file.isEmpty()) {
                continue;
            }

            Attachment attachment = uploadFile(file, refTable, refId);

            if (attachment != null) {
                result.add(attachment);
            }
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<Attachment> findFiles(String refTable, Long refId) {
        return attachmentRepository.findByRefTableAndRefIdOrderByFileIdAsc(refTable, refId);
    }

    @Transactional
    public void deleteFilesOnlyDb(String refTable, Long refId) {
        attachmentRepository.deleteByRefTableAndRefId(refTable, refId);
    }

    @Transactional
    public void deleteFilesWithPhysicalFile(String refTable, Long refId) {
        List<Attachment> files = attachmentRepository.findByRefTableAndRefId(refTable, refId);
        String normalizedUploadDir = resolveUploadDir();

        for (Attachment attachment : files) {
            try {
                File physicalFile = new File(normalizedUploadDir + attachment.getSavedFileName());

                if (physicalFile.exists()) {
                    physicalFile.delete();
                }
            } catch (Exception ignored) {
            }
        }

        attachmentRepository.deleteByRefTableAndRefId(refTable, refId);
    }

    private String resolveUploadDir() {
        if (uploadDir == null || uploadDir.isBlank()) {
            return "C:/upload/";
        }

        String normalized = uploadDir.replace("\\", "/");

        if (!normalized.endsWith("/")) {
            normalized += "/";
        }

        return normalized;
    }
}