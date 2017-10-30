package artsoftconsult.study.main;

import org.springframework.stereotype.Component;

@Component
public class Main {


//    public static void main(String[] arg) {
//        int i = 0;
//        while (i < 10) {
//            String password = "parola";
//            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//            String hashedPassword = passwordEncoder.encode(password);
//
//            System.out.println(hashedPassword);
//            i++;
//        }
//    }


//    public static void main(String[] arg) {
//        MutableDataSet options = new MutableDataSet();
//
//        // uncomment to set optional extensions
//        //options.set(Parser.EXTENSIONS, Arrays.asList(TablesExtension.create(), StrikethroughExtension.create()));
//
//        // uncomment to convert soft-breaks to hard breaks
//        //options.set(HtmlRenderer.SOFT_BREAK, "<br />\n");
//
//        Parser parser = Parser.builder(options).build();
//        HtmlRenderer renderer = HtmlRenderer.builder(options).build();
//
//        // You can re-use parser and renderer instances
//        Node document = parser.parse("**emphasized text**[enter link description here][1]\n" +
//                "\n" +
//                " - List item\n" +
//                " - List item\n" +
//                " - List item\n" +
//                " - \n" +
//                "\n" +
//                "\n" +
//                "----------\n" +
//                "\n" +
//                "        @Bean\n" +
//                "    public static PropertySourcesPlaceholderConfigurer\n" +
//                "    propertySourcesPlaceholderConfigurer() {\n" +
//                "        return new PropertySourcesPlaceholderConfigurer();\n" +
//                "    }\n" +
//                "\n" +
//                "    @Bean\n" +
//                "    public InternalResourceViewResolver viewResolver() {\n" +
//                "        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();\n" +
//                "        viewResolver.setViewClass(JstlView.class);\n" +
//                "        viewResolver.setPrefix(\"/WEB-INF/view/\");\n" +
//                "        viewResolver.setSuffix(\".jsp\");\n" +
//                "        return viewResolver;\n" +
//                "    }\n" +
//                "\n" +
//                "List item\n" +
//                "---------\n" +
//                "\n" +
//                "  [1]: http://www.google.ro");
//        String html = renderer.render(document);  // "<p>This is <em>Sparta</em></p>\n"
//        System.out.println(html);
//
//        document = parser.parse("![This is a picture i found on the internet][1]\n" +
//                "\n" +
//                "\n" +
//                "  [1]: https://i.imgur.com/YcP0tik.jpg");
//        html = renderer.render(document);  // "<p>This is <em>Sparta</em></p>\n"
//        System.out.println(html);
//
//    }

}
