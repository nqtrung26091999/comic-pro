package com.example.service.awss3;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;
import com.example.constant.AWSConstant;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static com.amazonaws.services.s3.model.ListObjectsV2Request.*;

@Service
public class AWSClient {
    private AmazonS3 s3Client;

    @Value(AWSConstant.END_POINT_URL)
    private String endpointUrl;
    @Value(AWSConstant.BUCKET_NAME)
    private String bucketName;
    @Value(AWSConstant.ACCESS_KEY)
    private String accessKey;
    @Value(AWSConstant.SECRET_KEY)
    private String secretKey;

    @PostConstruct
    private void initializeAmazon() {
        AWSCredentials credentials = new BasicAWSCredentials(this.accessKey, this.secretKey);
        this.s3Client = new AmazonS3Client(credentials);
    }

    private void uploadFileTos3bucket(String fileName, File file) {
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, fileName, file);
        s3Client.putObject(putObjectRequest);
    }

    private File convertMultiPartToFile(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        FileOutputStream fos = new FileOutputStream(convFile);
        fos.write(file.getBytes());
        fos.close();
        return convFile;
    }

    private String generateFileName(MultipartFile multiPart) {
        return new Date().getTime() + "-" +  multiPart.getOriginalFilename().replace(" ", "_");
    }

    public String uploadFile(MultipartFile multipartFile, String folder) {

        String fileUrl = "";
        try {
            File file = convertMultiPartToFile(multipartFile);
            String fileName =  folder + generateFileName(multipartFile);
            fileUrl = endpointUrl + "/" + fileName;
            uploadFileTos3bucket(fileName, file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileUrl;
    }

    public void deleteFileFromS3(String bucketName ,String path) {
        S3Object object = s3Client.getObject(bucketName, path);
        DeleteObjectRequest request = new DeleteObjectRequest(bucketName, object.getKey());
        s3Client.deleteObject(request);
    }

    public S3Object getObjectFromS3(String bucketName, String path) {
        try {
            return s3Client.getObject(bucketName, path);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public List<String> listObjects(String bucketName) {
        ObjectListing objectListing = s3Client.listObjects(bucketName);
        return objectListing.getObjectSummaries()
                .stream()
                .map(S3ObjectSummary::getKey)
                .collect(Collectors.toList());
    }
}
