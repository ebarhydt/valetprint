class Item < ActiveRecord::Base
  belongs_to :order
  mount_uploader :document, DocumentUploader

  def get_filename
    document.file.filename
  end
  def get_document
    document.file
  end

  def get_color
    if color 
      "color"
    else
      "b&w"
    end
  end
end
