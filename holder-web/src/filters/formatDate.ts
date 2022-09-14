import moment from 'moment-timezone';

const formatDate = (value: Date, filterFormat: string | undefined) => {
  if (value) {
    return moment(value).format(filterFormat || 'lll');
  }

  return '';
};

export default formatDate;
