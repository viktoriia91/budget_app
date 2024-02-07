module CategoriesHelper
  def tailwind_color(category)
    @color_variants = {
      gray: 'bg-stone-400',
      rose: 'bg-rose-400',
      blue: 'bg-sky-600',
      green: 'bg-green-600',
      indigo: 'bg-indigo-300',
      purple: 'bg-purple-500',
      pink: 'bg-pink-400',
      red: 'bg-red-500',
      yellow: 'bg-yellow-300',
      orange: 'bg-orange-500',
      teal: 'bg-teal-500',
      cyan: 'bg-cyan-400',
      lime: 'bg-lime-400',
      emerald: 'bg-emerald-400',
    }
    if category == :new_category
      @color_variants.map { |key, value| [key, key.to_s] }
    else
      if category.present? && category.color.present?
        @color_variants[category.color.to_sym]
      else
        'bg-gray-100 hover:bg-gray-100'
      end
    end
  end
end
