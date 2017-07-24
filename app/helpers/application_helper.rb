module ApplicationHelper
    class CodeRayify < Redcarpet::Render::HTML
        def block_code(code, language)
            language ||= :plaintext
            CodeRay.scan(code, language).div
        end
    end
    
    def markdown(text)
        coderayified = CodeRayify.new(:hard_wrap => true,
                                      :filter_html => true)
        
        render_options = {
            filter_html: true,
            hard_wrap: true,
            link_attributes: {rel: 'nofollow'}
        }

        renderer = Redcarpet::Render::HTML.new(render_options)

        extensions = {
            autolink: true,
            no_intra_emphasis: true,
            #disable_indented_code_blocks: true,
            fenced_code_blocks: true,
            #lax_html_blocks: true,
            lax_spacing: true,
            strikethrough: true,
            superscript: true
        }
        Redcarpet::Markdown.new(coderayified, extensions).render(text).html_safe
    end
    
end
