import os

# Critical: pip install werkzeug==0.16.0

from werkzeug.contrib.cache import RedisCache

REDIS_SERVER_IP = os.getenv('REDIS_SERVER_IP', '')
REDIS_PASSWORD = os.getenv('REDIS_PASSWORD', '')

SUPERSET_CACHE_REDIS_URL = "".join(['redis://:', REDIS_PASSWORD, '@', REDIS_SERVER_IP, ':6379/1'])
SUPERSET_BROKER_URL = "".join(['redis://:', REDIS_PASSWORD, '@', REDIS_SERVER_IP, ':6379/0'])
SUPERSET_CELERY_RESULT_BACKEND = "".join(['redis://:', REDIS_PASSWORD, '@', REDIS_SERVER_IP, ':6379/0'])

CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_HOST': 'redis',
    'CACHE_REDIS_PORT': 6379,
    'CACHE_REDIS_DB': 1,
    'CACHE_REDIS_URL': SUPERSET_CACHE_REDIS_URL
}

class CeleryConfig(object):
    BROKER_URL = SUPERSET_BROKER_URL
    CELERY_IMPORTS = ('superset.sql_lab', )
    CELERY_RESULT_BACKEND = SUPERSET_CELERY_RESULT_BACKEND
    CELERY_ANNOTATIONS = {'tasks.add': {'rate_limit': '10/s'}}
CELERY_CONFIG = CeleryConfig
RESULTS_BACKEND = RedisCache(
    host=REDIS_SERVER_IP,
    port=6379,
    key_prefix='superset_results',
    password=REDIS_PASSWORD
)
