module Highrise
  class SubjectData < Base
    def==other
      attributes["value"] == other.attributes["value"] &&
      attributes["subject_field_label"] == other.attributes["subject_field_label"]
    end
  end
end