#ifndef UTIME_H_
#define UTIME_H_

struct utimbuf {
	time_t actime;       /* access time */
	time_t modtime;      /* modification time */
};

#endif