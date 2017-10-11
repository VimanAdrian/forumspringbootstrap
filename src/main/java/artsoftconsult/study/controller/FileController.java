package artsoftconsult.study.controller;

import artsoftconsult.study.service.UserService;
import artsoftconsult.study.utils.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class FileController {

    @Autowired
    private Environment env;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/uploadOneFile", method = RequestMethod.POST)
    protected void singleFileUpload(@RequestParam("file") MultipartFile file, @RequestParam("username") String username, HttpServletResponse response) {
        try {
            byte[] bytes = file.getBytes();
            String filename = RandomUtils.generateFileName(file.getOriginalFilename());
            Path path = Paths.get(env.getProperty("fileLocation") + filename);
            Files.write(path, bytes);
            userService.updateProfileImage(filename, username);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            response.sendRedirect("/account");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/profileImage/*", method = RequestMethod.GET)
    protected void singleFileDownload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filename = URLDecoder.decode(request.getRequestURI().split("/")[2], "UTF-8");
        File file = new File(env.getProperty("fileLocation"), filename);
        InputStream is = new BufferedInputStream(new FileInputStream(file));
        //mimeType = URLConnection.guessContentTypeFromStream(is);
        response.setHeader("Content-Type", URLConnection.guessContentTypeFromStream(is));
        response.setHeader("Content-Length", String.valueOf(file.length()));
        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
        Files.copy(file.toPath(), response.getOutputStream());
    }

}


