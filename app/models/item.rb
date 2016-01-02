class Item < ActiveRecord::Base
  belongs_to :order
  mount_uploader :document, DocumentUploader

  def get_filename
    document.file.filename
  end
  def get_document
    document.file
  end
end
