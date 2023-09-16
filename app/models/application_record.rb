class ApplicationRecord < ActiveRecord::Base #継承。初期搭載の様々な処理がARB内にある。
  self.abstract_class = true
end
