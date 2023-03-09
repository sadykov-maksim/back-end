from django.shortcuts import render

# Create your views here.
def index(request):
    context = {
        'title': 'Home page'
    }

    return render(request, 'main/index.html', context=context, content_type='text/html', status=200)
