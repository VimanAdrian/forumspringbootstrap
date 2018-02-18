package artsoftconsult.study.utils;

import com.vladsch.flexmark.Extension;
import com.vladsch.flexmark.ast.IndentedCodeBlock;
import com.vladsch.flexmark.ast.Node;
import com.vladsch.flexmark.ext.autolink.AutolinkExtension;
import com.vladsch.flexmark.html.AttributeProvider;
import com.vladsch.flexmark.html.AttributeProviderFactory;
import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.html.IndependentAttributeProviderFactory;
import com.vladsch.flexmark.html.renderer.AttributablePart;
import com.vladsch.flexmark.html.renderer.NodeRendererContext;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.util.html.Attributes;
import com.vladsch.flexmark.util.options.MutableDataHolder;
import com.vladsch.flexmark.util.options.MutableDataSet;

import java.util.Arrays;

public class MyAttributeProvider {
    public static String commonMark(String markdown) {
        MutableDataHolder options = new MutableDataSet();
        options.set(Parser.EXTENSIONS, Arrays.asList(new Extension[]{AutolinkExtension.create(), MyAttributeProvider.SampleExtension.create()}));

        // change soft break to hard break
        options.set(HtmlRenderer.SOFT_BREAK, "<br/>");

        Parser parser = Parser.builder(options).build();
        Node document = parser.parse(markdown);
        HtmlRenderer renderer = HtmlRenderer.builder(options).build();
        final String html = renderer.render(document);
        return html;
    }

    static class SampleExtension implements HtmlRenderer.HtmlRendererExtension {
        static MyAttributeProvider.SampleExtension create() {
            return new MyAttributeProvider.SampleExtension();
        }

        @Override
        public void rendererOptions(final MutableDataHolder options) {
            // add any configuration settings to options you want to apply to everything, here
        }

        @Override
        public void extend(final HtmlRenderer.Builder rendererBuilder, final String rendererType) {
            rendererBuilder.attributeProviderFactory(MyAttributeProvider.SampleAttributeProvider.Factory());
        }
    }

    static class SampleAttributeProvider implements AttributeProvider {

        static AttributeProviderFactory Factory() {
            return new IndependentAttributeProviderFactory() {
                @Override
                public AttributeProvider create(NodeRendererContext context) {
                    //noinspection ReturnOfInnerClass
                    return new MyAttributeProvider.SampleAttributeProvider();
                }
            };
        }

        @Override
        public void setAttributes(final Node node, final AttributablePart part, final Attributes attributes) {
            if (node instanceof IndentedCodeBlock && part == AttributablePart.NODE) {
                // Put info in custom attribute instead
                attributes.addValue("class", "prettyprint");
                attributes.addValue("class", "linenums");
            }
        }
    }
}