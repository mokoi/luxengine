/****************************
Copyright © 2006-2011 Luke Salisbury
This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
****************************/
#ifndef _WORKERTHREAD_H_
	#define _WORKERTHREAD_H_

	#include <SDL/SDL.h>
	#include <SDL/SDL_thread.h>

	class WorkerThread
	{
		public:
			WorkerThread(int32_t (*fn)(void*), void * data);
			~WorkerThread();

			bool Active();
			void Lock();
			void Unlock();

			void * data;
			bool _active;
			int32_t results;
		private:
			SDL_Thread * thread;
			SDL_mutex * mutex;
	};
#endif
