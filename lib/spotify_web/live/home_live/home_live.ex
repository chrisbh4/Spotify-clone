defmodule SpotifyWeb.HomeLive do
  use SpotifyWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class=" h-[400px] w-full flex">
      <div class="bg-black h-[500px] w-[30%]">
        <div class="bg-red-500 h-[150px] w-full">
          <div class="bg-yellow-300 h-[70px]">Home </div>
          <div class="bg-purple-300 h-[80px]">Search </div>
         </div>
        <div class="bg-gray-500 h-[500px] w-full">
          <h1 class="text-white text-xl">Library </h1>
          <div>
            <div class="bg-red-300 h-[150px] mt-[8%]">Create Playlist </div>
            <div class="bg-blue-300 h-[150px] mt-[5%]">Browse Podcast </div>
          </div>
        </div>
      </div>
        <div class="bg-gray-500 h-[650px] w-full">
          <div>Spotify Playlist </div>
          <ul role="list" class="grid grid-cols-2 gap-x-4 gap-y-8 sm:grid-cols-3 sm:gap-x-6 lg:grid-cols-4 xl:gap-x-8">
            <li class="relative">
            <div class="group h-1/2 aspect-h-7 aspect-w-10 block w-full overflow-hidden rounded-lg bg-gray-100 focus-within:ring-2 focus-within:ring-indigo-500 focus-within:ring-offset-2 focus-within:ring-offset-gray-100">
              <img src="https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80" alt="" class="pointer-events-none object-cover group-hover:opacity-75">
              <button type="button" class="">Click Me</button>
            </div>

            </li>
            <li class="relative h-1/2">
            <div class="group h-2/3 aspect-h-7 aspect-w-10 block w-full overflow-hidden rounded-lg bg-gray-100 focus-within:ring-2 focus-within:ring-indigo-500 focus-within:ring-offset-2 focus-within:ring-offset-gray-100">
              <img src="https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80" alt="" class="pointer-events-none object-cover group-hover:opacity-75">
              <button type="button" class="">Click Me</button>
            </div>

            </li>
            <li class="relative">
            <div class="group aspect-h-7 aspect-w-10 block w-full overflow-hidden rounded-lg bg-gray-100 focus-within:ring-2 focus-within:ring-indigo-500 focus-within:ring-offset-2 focus-within:ring-offset-gray-100">
              <img src="https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80" alt="" class="h-1/2 pointer-events-none  group-hover:opacity-75">
              <button type="button" class="">Click Me</button>
            </div>
            </li>
          </ul>
        </div>
    </div>
    """
  end
end
