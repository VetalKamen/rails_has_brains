module ControllerMacros

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def it_renders_404_when_item_not_found(*actions)
      actions.each do |a|
        it "#{a} renders 404 when item is not found" do
          verb = case a
                 when :update
                   "PATCH"
                 when :destroy
                   "DELETE"
                 else
                   'GET'
                 end
          process a, verb, { id: 0 }
          response.status.should == 404
        end

      end
    end
  end
end