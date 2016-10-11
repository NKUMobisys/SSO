@ng_app = angular.module(
	'sso',
	[
		'ngAnimate',
		'ngMaterial',
		'ngMdIcons',
		'ngResource',
		'ngAutodisable',
		'md.data.table',
		# 'angular.validators',
	]
)
.config ["$httpProvider", '$resourceProvider', (provider, resource)->
	provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
	resource.defaults.stripTrailingSlashes = false;
]
.config ["$mdDateLocaleProvider", ($mdDateLocaleProvider)->
	# http://stackoverflow.com/questions/32566416/change-format-of-md-datepicker-in-angular-material
	fomat_date = (date)->

	$mdDateLocaleProvider.formatDate = (date)->
		return null unless date
		return moment(date).format('YYYY/MM/DD')

	$mdDateLocaleProvider.parseDate = (dateString)->
		m = moment(dateString, 'YYYY/MM/DD', true)
		return if m.isValid() then m.toDate() else new Date(NaN)

	$mdDateLocaleProvider.months = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
	$mdDateLocaleProvider.shortMonths = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'];
	$mdDateLocaleProvider.days = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
	$mdDateLocaleProvider.shortDays = ['日', '一', '二', '三', '四', '五', '六']
	$mdDateLocaleProvider.firstDayOfWeek = 1
]
.run ['$rootScope', ($rootScope)->
	$rootScope._gen_date = (date)->
		new Date(date)
	$rootScope.Routes = window.Routes
]



# http://kurtfunai.com/2014/08/angularjs-and-turbolinks.html
# https://docs.angularjs.org/error/ng/btstrpd
# http://stackoverflow.com/questions/36110789/rails-5-how-to-use-document-ready-with-turbo-links
$(document).on('turbolinks:load', ->
	# below can not use because of turbolinks's bug
	# unless (document.documentElement.hasAttribute("data-turbolinks-preview"))
	unless ($('body').attr("ng-bootstraped")) # Temporarily solution
		console.log 'not cached show'
		angular.bootstrap(document.body, ['sso'])
		$('body').attr("ng-bootstraped", true)
	else
		console.log 'cached show'

)

$(document).on('turbolinks:before-cache', ->
	# angular.element("body").scope().$broadcast("$destroy")
)