unless Array.method_defined? :keep_if
  class Array
    def keep_if
      delete_if { |x| not yield(x) }
    end
  end
end
