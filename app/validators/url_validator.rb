# A simple Rails validator for validating a string is actually a URL.
#
# In the model, use...
#   validates :url, :presence => true, :url => true
class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, url)
    @record, @attribute, @url = record, attribute, url

    return errors unless url_valid?
  end

  private

  def url_valid?
    begin
      URI.parse(@url).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
  end

  def errors
    @record.errors[@attribute] << (options[:message] || I18n.t('errors.messages.url'))
  end
end
