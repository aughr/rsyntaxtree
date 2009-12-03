# just a PORO, not ActiveRecord
class SyntaxTree
  FONTS_DIR = "#{RAILS_ROOT}/lib/fonts"
  FONT_SERIF      = "#{FONTS_DIR}/vera/VeraSe.ttf"
  FONT_NONSERIF   = "#{FONTS_DIR}/vera/Vera.ttf"
  FONT_MBSERIF    = "#{FONTS_DIR}/ipa/IPAPMincho.ttf"
  FONT_MBNONSERIF = "#{FONTS_DIR}/ipa/IPAPGothic.ttf"
  FONT_MBNONJA    = "#{FONTS_DIR}/wqy-zenhei/wqy-zenhei.ttf"
  
  def initialize(options={})
    options[:format] ||= 'png'
    options[:serif] = options[:serif] == 'on'
    options[:fontsize] ||= 14
    options[:fontsize] = options[:fontsize].to_i
    options[:terminal] ||= "triangle"
    
    @data = options.delete(:data) || ""
    @graph_engine = (options[:format] =~ /svg/ ? SVGGraph : TreeGraph)
    @options = options
  end
  
  def render
    parser = StringParser.new(@data)
    
    if(!parser.validate)
      nil
    else
      parser.parse
      parser.auto_subscript if @options[:autosub]
      elist = parser.get_elementlist
      
      graph = @graph_engine.new(elist, @options[:symmetrize], @options[:color], @options[:terminal], font, @options[:fontsize])
      if @options[:format] == "svg"
        image_data = graph.svg_data
      else
        image_data = graph.to_blob(@options[:format])
      end
      graph.destroy
      image_data
    end
  end
  
  def svg?
    true if @options[:format] =~ /svg/
  end
  
  def format
    @options[:format]
  end
  
  protected
  
  def data_for_url
  end
  
  def font
    if multibyte?
      if japanese? || !File.exist?(FONT_MBNONJA)
        if @options[:serif]
          FONT_MBSERIF
        else
          FONT_MBNONSERIF
        end
      else
        FONT_MBNONJA
      end
    else
      if @options[:serif]
        FONT_SERIF
      else
        FONT_NONSERIF
      end
    end
  end
  
  def multibyte?
    @data.strip.split(//).each do |chr|
      return true unless /([!-~]|\s)/ =~ chr
    end
    false
  end

  def japanese? #check if text contains hiragana or katakana
    @data.strip.split(//).each do |chr|
      return true if /(\xe3(\x82[\xa1-\xbf]|\x83[\x80-\xbf]))/ =~ chr ||
                     /(\xe3(\x81[\x80-\xbf]|\x82[\x80-\xa0]))/ =~ chr
    end
    false
  end
  
end