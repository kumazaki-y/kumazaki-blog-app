class ApplicationController < ActionController::Base # APBから継承。railsで元々膨大な処理が設定されている。
    def current_user
        ActiveDecorator::Decorator.instance.decorate(super) if super.present?
        super #deviseとDecoratorの相性が悪くエラーが発生するため、それを解消するコード。
      end
end
